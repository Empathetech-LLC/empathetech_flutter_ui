node('00-flutter') {
  try {
    stage('checkout') {
      checkout scm
    }

    def baseBranch = 'main' // CPP (Copy/Paste Point)

    if (env.BRANCH_NAME != 'main') {
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
            sh "git fetch origin ${baseBranch}:${baseBranch} ${env.BRANCH_NAME}:${env.BRANCH_NAME}"
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
          def outdated = sh(script: 'flutter pub outdated', returnStdout: true).trim()
          if (!outdated.contains('direct dependencies: all up-to-date')) {
            println outdated
            input message: 'Some packages are outdated. Do you want to continue?', ok: 'Continue'
          } else {
            println "All direct dependencies are up to date!"
          }
        }
      }

      // Run flutter package analysis
      stage('Flutter Package Analysis') {
        script {
          def analysis = sh(script: 'flutter analyze', returnStdout: true).trim()
          if (!analysis.contains('No issues found!')) {
            println analysis
            input message: 'Flutter analysis found issues. Do you want to continue?', ok: 'Continue'
          } else {
            println "No issues found! Good job!"
          }
        }
      }
    }

    if (env.BRANCH_NAME == 'main') {
      withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
        stage('Create Git release') {
          sh "git fetch origin ${baseBranch}:${baseBranch}"
          sh "git checkout ${baseBranch}"

          // Fail if a tag already exists
          if (sh(script: 'git describe --exact-match HEAD', returnStatus: true) == 0) {
            error("ERROR: Current commit already has a git tag")
          }

          // Gather release information
          def version = readFile('APP_VERSION').trim()
          def changelog = readFile('CHANGELOG.md').split("\n")

          // Define pattern to match version header
          def versionPattern = ~/## \[${version}\] - \d{4}-\d{2}-\d{2}/

          // Find start and end lines for the version's section
          def startIndex = changelog.findIndexOf { it == versionPattern }
          def endIndex = changelog.findIndexOf(startIndex + 1) { it ==~ /## \[\d+\.\d+\.\d+\] - \d{4}-\d{2}-\d{2}/ }

          if (endIndex == -1) endIndex = changelog.size()

          // Extract the section
          def notes = changelog[startIndex..(endIndex - 1)].join("\n")

          sh "gh release create \"${version}\" -t \"${version}\" -n \"${notes}\""
        }
      }
    }

  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}