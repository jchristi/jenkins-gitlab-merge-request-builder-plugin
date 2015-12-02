# Gitlab Merge Request Builder Plugin

A plugin that allows Jenkins to build merge requests.

This plugin fetches the source and target branches of a Gitlab merge request and makes them available
to your build via build parameters. Once the build completes, Jenkins will leave a comment on the merge
request indicating whether the merge request was successful.

## Building

To build the plugin hpi file all you need to do is run the `make` target in the Makefile. Note: requires docker be installed.

## Prerequisites

* Whilst there is no explicit dependency on the [Git plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin),
  it's strongly recommended that you install it since Jenkins will be unable to fetch the source code for your project.

## Installation

* Ensure that a Jenkins user exists within Gitlab and has access to the repository. Ensure that the user
  has **Reporter** level access to the project. Please note that if you would like to use the Auto-merge feature
  Jenkins needs to have **Developer** access to the project.
* Install the plugin in Jenkins.
    * The plugin is hosted on the [Jenkins Plugin repository](https://wiki.jenkins-ci.org/display/JENKINS/Gitlab+Merge+Request+Builder+Plugin)
    * Go to ``Jenkins`` -> ``Manage Plugins`` -> ``Available``
    * Search for ``Gitlab Merge Request Builder``
    * And install it
    * Ensure you restart Jenkins
* Go to ``Manage Jenkins`` -> ``Configure System`` -> ``Gitlab Merge Request Builder``
* Set the ``Gitlab Host URL`` to the base URL of your Gitlab server
* Set your ``Jenkins Username`` for the Jenkins user (defaults to jenkins)
* Set your ``Jenkins API Token`` for the Jenkins user. This can be found by logging into Gitlab as Jenkins
  and going to the user profile section.
* Set/change any of the other available parameters as necessary. If you host Gitlab over an SSL connection
  you may want to enable ignoring certificate errors.
* ``Save`` to preserve your changes.
* Go to `Manage Jenkins` -> `Configure Global Security` and set `Markup Formatter` to *Safe HTML*. It will make Jenkins display links in build history properly.

## Creating a Job

* Create a new job by going to ``New Job``
* Set the ``Project Name``
* Feel free to specify the ``GitHub Project`` URL as the URL for the Gitlab project (if you have the GitHub plugin installed)
* In the ``Source Code Management`` section:
    * Click ``Git`` and enter your Repository URL and in Advanced set its Name to ``origin``
    * For merge requests from forked repositories add another repository with Repository URL ``${gitlabSourceRepository}`` and in Advanced set Name to ``${gitlabSourceName}``
    * In ``Branch Specifier`` enter ``refs/remotes/origin/${gitlabSourceBranch}`` or for merge requests from forked repositories enter ``refs/remotes/${gitlabSourceName}/${gitlabSourceBranch}``
    * In the ``Additional Behaviours`` section:
        * Click the ``Add`` drop down button and the ``Merge before build`` item
        * Specify the name of the repository as ``origin`` (if origin corresponds to Gitlab) and enter the
          ``Branch to merge to`` as ``${gitlabTargetBranch}``
        * **Ensure ``Prune stale remote-tracking branches`` is not added**
* In the ``Build Triggers`` section:
    * Check the ``Gitlab Merge Requests Builder``
    * Enter the ``Gitlab Project Path``, this might be something like ``your_group/your_project`` for Gitlab URL ``http://git.tld/your_group/your_project``
    * The ``Target Branch Regex`` may be configured to whitelist this job for certain target branches. If left empty, every valid merge request for the configured project path will trigger this job.
    * The ``Use HTTP(S) URL`` checkbox should be used if you want Jenkins to
clone/fetch using HTTP(S) instead of SSH.
* Configure any other pre build, build or post build actions as necessary
* ``Save`` to preserve your changes

You can trigger a job a manually by clicking ``This build is parameterized`` and adding the relevant build parameters.
These include:

* gitlabSourceRepository (for MRs from forked repos)
* gitlabSourceName (for MRs from forked repos)
* gitlabSourceBranch
* gitlabTargetBranch
* gitlabMergeRequestId

__Note:__  a manually triggered build will not add build triggered/succeeded/failed comments to the merge request.
__Note:__  You should ensure that the 'Global Config user.name Value' and 'Global Config user.email Value' are both set for your git plugin.  In some cases, you will get an error indicating that a branch cannot be merged if these are not set.

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the version, or history. If you want to have your own version, or is otherwise necessary, that is fine,
  but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Tim Olshansky. See LICENSE for further details.
