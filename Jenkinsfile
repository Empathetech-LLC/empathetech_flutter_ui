node('00-flutter') {
  try {
    stage('checkout') {
      checkout scm
    }

    def baseBranch = 'main' // CPP (Copy/Paste Point)
    def currentVersion = readFile('APP_VERSION').trim()

    if (env.BRANCH_NAME != baseBranch) {
      // Validate that all of the repos versioning trackers have been updated, and that they match
      stage('Validate versioning') {
        withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
          script {
            //// Initialize consts & trackers

            def versionRegex = "[0-9]+.[0-9]+.[0-9]+" // CPP
            def trackedFiles = ['APP_VERSION','CHANGELOG.md','pubspec.yaml'] // CPP

            def versions = new HashSet()
            def result = 0
            
            //// Check for updates from base branch

            println "Validating:\n\t${trackedFiles}"

            // Gather the names of all files that have been updated
            if (env.CHANGE_ID) {
              // If "this" a PR
              sh "git fetch origin ${baseBranch}:${baseBranch} refs/pull/${env.CHANGE_ID}/head:PR-${env.CHANGE_ID}"
            } else {
              // If "this" regular branch
              sh "git fetch origin ${baseBranch}:${baseBranch} ${env.BRANCH_NAME}:${env.BRANCH_NAME}"
            }

            def updatedFiles = sh(script: "git diff --name-only ${env.BRANCH_NAME} ${baseBranch}", returnStdout: true).trim().split("\n")
            println "Updated files:\n$updatedFiles"

            trackedFiles.each { curr_file ->
              // Check if the tracked file has been updated
              if (!updatedFiles.contains(curr_file)) {
                // File wasn't updated, set result to failure
                println "$curr_file has NOT been updated"
                result = -1
              } else {
                println "$curr_file has been updated"
              }

              // Find all version numbers in the tracked file
              def versionMatches = sh(script: "grep -oE $versionRegex $curr_file", returnStdout: true).trim()
              
              // Keep the first (i.e. latest) match
              def latestVersion = versionMatches.split("\n")[0]

              println "$curr_file returned $latestVersion"
              
              // Track unique version number matches
              if(!versions.contains(latestVersion)) {
                versions.add(latestVersion)
              }
            }

            //// Check for matching versions

            println "\n${versions.size()} version(s) found:\n\t${versions}"

            if(versions.size() != 1) {
              // More than one version number was found, set result to failure
              result = -1
            }

            //// Return result

            if(result != 0) {
              error("Errors found, read above log")
            } else {
              println "\nPassed!\n"
            }
          }
        }
      }

      // Validate all the flutter packages are on their latest version
      stage('Validate Flutter Dependencies') {
        script {
          def allPaths = sh(script: "grep 'path:' pubspec.yaml", returnStdout: true).trim().split("\n")
          allPaths.each { path ->
            if (!path.contains('^') && !path.startsWith('#')) { 
              error('Some packages are being built locally. Update all to remote to continue.')
            }
          }
          
          def outdated = sh(script: 'flutter pub outdated', returnStdout: true).trim()
          println outdated
        
          if (!outdated.contains('direct dependencies: all up-to-date')) {
            input message: 'Some packages are outdated. Do you want to continue?', ok: 'Continue'
          }

          def validate = sh(script: 'dart run dependency_validator', returnStdout: true).trim()
          println validate
        
          if (!validate.contains('No dependency issues found')) {
            input message: 'Dependency validator found issues. Do you want to continue?', ok: 'Continue'
          }
        }
      }

      // Run flutter package analysis
      stage('Flutter Package Analysis') {
        script {
          def analysis = sh(script: 'flutter analyze', returnStdout: true).trim()
          println analysis

          if (!analysis.contains('No issues found!')) {
            input message: 'Flutter analysis found issues. Do you want to continue?', ok: 'Continue'
          } else {
            println "No issues found! Good job!"
          }

          def docs = sh(script: 'dart doc . 2>&1', returnStdout: true).trim()
          println docs

          if (!docs.contains('0 errors')) {
            input message: 'Dart doc found errors. Do you want to continue?', ok: 'Continue'
          } else {
            println "No errors found! Good job!"
          }
        }
      }

      // Do a publication dry run
      stage('Dart publish dry-run') {
        script {
          def results = sh(script: 'dart pub publish --dry-run 2>&1', returnStdout: true).trim()
          println results
          
          if (!results.contains('Package has 0 warnings')) {
            input message: 'Dart publish found issues. Do you want to continue?', ok: 'Continue'
          } else {
            println "No issues found! Good job!"
          }
        }
      }
    }

    if (env.BRANCH_NAME == baseBranch) {
      withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
        withEnv(["GH_TOKEN=$GIT_PASSWORD"]) {
          stage('Create Git release') {
            sh "git fetch origin ${baseBranch}:${baseBranch}"
            sh "git checkout ${baseBranch}"

            // Fail if a tag already exists
            if (sh(script: 'git describe --exact-match HEAD', returnStatus: true) == 0) {
              error("ERROR: Current commit already has a git tag")
            }

            ////  Gather CHANGELOG notes for PRs' bodies
            
            def changelog = readFile('CHANGELOG.md').split("\n")

            // Define pattern to match version header
            def versionPattern = ~/## \[\d+\.\d+\.\d+\] - \d{4}-\d{2}-\d{2}/
            def currentVersionPattern = ~/## \[${currentVersion}\] - \d{4}-\d{2}-\d{2}/

            // Find start and end lines for the current version's section
            def startIndex = changelog.findIndexOf { it ==~ currentVersionPattern }
            def endIndex = changelog.findIndexOf(startIndex + 1) { it ==~ versionPattern }

            if (endIndex == -1) endIndex = changelog.size()

            // Extract the section
            def notes = changelog[startIndex..(endIndex - 1)].join("\n")

            sh "gh release create \"${currentVersion}\" -t \"${currentVersion}\" -n \"${notes}\""
          }
        }
      }
    }

  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}