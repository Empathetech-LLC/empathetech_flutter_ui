@Library('empathetechScripts') _

node('00-flutter') {
  try {
    stage('checkout') {
      checkout scm
    }

    def trackedFiles = ['APP_VERSION','CHANGELOG.md','pubspec.yaml']
    def baseBranch = 'main'

    if (env.BRANCH_NAME != baseBranch) {
      // Validate that all of the repos versioning trackers have been updated, and that they match
      stage('Validate versioning') {
        withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
          universalDev.validateVersioning(trackedFiles, env.CHANGE_ID, baseBranch, env.BRANCH_NAME)
        }
      }

      // Validate all the flutter packages are on their latest version
      stage('Validate Flutter Dependencies') {
        flutterDev.validateDependencies()
      }

      // Validate all the locales are up to date
      stage('Validate l10n') {
        flutterDev.validatel10n()
      }

      // Run flutter package analysis
      stage('Flutter Package Analysis') {
        flutterProd.analyzePackage()
      }

      // Do a publication dry run
      stage('Dart publish dry-run') {
        flutterProd.dryRun()
      }
    }

    if (env.BRANCH_NAME == baseBranch) {
      withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
        withEnv(["GH_TOKEN=$GIT_PASSWORD"]) {
          stage('Create Git release') {
            git.createRelease(baseBranch)
          }
        }
      }
    }

  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}
