organizationFolder('gsg-org') {
    organizations {
        github {
            apiUri('https://api.github.com')
            credentialsId('github-webhooks')
            repoOwner('grvvy')
            traits {
                gitHubBranchDiscovery {
                    strategyId(1)
                }
                gitHubPullRequestDiscovery {
                    strategyId(1)
                }
            }
        }
    }
    configure { node ->
        def traits = node / 'navigators' / 'org.jenkinsci.plugins.github__branch__source.GitHubSCMNavigator' / 'traits'
        // Not discovered by Job-DSL: need to be configured as raw-XML
        traits << 'org.jenkinsci.plugins.github__branch__source.ForkPullRequestDiscoveryTrait' {
            strategyId(1) // 1-Merging the pull request with the current target branch revision
            trust(class: 'org.jenkinsci.plugins.github_branch_source.ForkPullRequestDiscoveryTrait$TrustContributors')
        }
    }
    triggers {
        periodicFolderTrigger {
            interval('1d')
        }
    }
    orphanedItemStrategy {
        discardOldItems {
            numToKeep(1)
        }
    }
}
