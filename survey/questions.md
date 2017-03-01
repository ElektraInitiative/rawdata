# Questions of the survey

* How old are you?
* Which country are you from?
* Which is the highest degree that you have?
  * no degree
  * still a student
  * bachelor
  * master
  * phd
* What is your occupation?
  * software developer
  * administrator
  * student
  * researcher
  * other
* In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project.
* Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?
  * getenv/environment variables (e.g. PATH)
    * have not used or don't know it
    * had contact with
    * used in source code
  * command line arguments
    * have not used or don't know it
    * had contact with
    * used in source code
  * XSettings
    * have not used or don't know it
    * had contact with
    * used in source code
  * GSettings
    * have not used or don't know it
    * had contact with
    * used in source code
  * QSettings
    * have not used or don't know it
    * had contact with
    * used in source code
  * KConfig (from KDE Frameworks)
    * have not used or don't know it
    * had contact with
    * used in source code
  * dconf
    * have not used or don't know it
    * had contact with
    * used in source code
  * configuration files (e.g. /etc/papersize, /etc/motd, …)
    * have not used or don't know it
    * had contact with
    * used in source code
  * freedesktop standards (e.g. shared-mime-info)
    * have not used or don't know it
    * had contact with
    * used in source code
  * registry (if Windows support available)
    * have not used or don't know it
    * had contact with
    * used in source code
  * plist (if Mac OS X support available)
    * have not used or don't know it
    * had contact with
    * used in source code
* What is your experience with the following configuration systems/libraries/APIs?
  * getenv/environment variables (e.g. http_proxy)
    * bad
    * confused
    * help
    * neutral
    * good
  * command-line arguments
    * bad
    * confused
    * help
    * neutral
    * good
  * XSettings
    * bad
    * confused
    * help
    * neutral
    * good
  * GSettings
    * bad
    * confused
    * help
    * neutral
    * good
  * QSettings
    * bad
    * confused
    * help
    * neutral
    * good
  * KConfig (from KDE Frameworks)
    * bad
    * confused
    * help
    * neutral
    * good
  * dconf
    * bad
    * confused
    * help
    * neutral
    * good
  * configuration files (e.g. /etc/papersize, /etc/motd, …)
    * bad
    * confused
    * help
    * neutral
    * good
  * freedesktop standards (e.g. shared-mime-info)
    * bad
    * confused
    * help
    * neutral
    * good
  * registry (if Windows support available)
    * bad
    * confused
    * help
    * neutral
    * good
  * plist (if Mac OS X support available)
    * bad
    * confused
    * help
    * neutral
    * good
* In which way have you used or contributed to the configuration system/library/API in your previosly mentioned FLOSS project(s)?
    * introduced a new configuration file format (e.g. a new INI dialect
    * introduced a new configuration system/library/API
    * implemented a configuration file parser
    * used an internal configuration system/library/API
    * used an external configuration system/library/API (like those in previous question)
    * implemented other configuration related artifacts
    * most of my contributions were non-configurable
* Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)
  * to improve user experience
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * because common/default settings are already available (e.g. in /etc/papersize)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * because guidelines recommended it (e.g. $HOME in POSIX)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * because I am convinced it should be done
    * not important
    * slightly important
    * moderately important
    * important
    * very important      
  * other: (Please name it after making a selection)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
* Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?
  * so that users avoid common errors
  * for rigorous validation
  * for documentation (looking up what the value does)
  * for code generation accessing configuration
  * for documentation generation (e.g. man pages, user guide)
  * for user interface generation (e.g. generate combo box with specified answers)
  * for reuse of configuration items (specifying links)
  * for external tools accessing configuration
  * to simplify maintenance
  * I would not because they are too complicated
  * I would not because it creates inconsistencies
  * I would not (use other to write why)
* Why do you thing configuration should be reduced?
  * to provide better user experience
  * because use-cases which are rarely used should not be supported
  * because only standard use-cases should be supported
  * to prevent errors and misconfiguration
  * to simplify code maintenance
  * because auto-detection should be preferred
  * auto-detection should always be overridable
  * I never find time for this task
  * I do not think it should be reduced
* Which effort do you think is worthwhile for providing better configuration experience?
  * provide proper default values
  * reading environment variables
  * reading configuration of other applications
  * accessing system-environment APIs (e.g. GSettings, XSettings)
  * adding dependency to library that only does detection (e.g. libpaper)
  * accessing external APIs (which adds new dependencies)
  * reading /proc and other OS-specific sources
  * detecting network-properties and bandwidth
  * I do not think such effort would be useful
* How important is it to expose configuration options in the following ways?
  * native GUI (e.g. GTK, Qt)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * a web GUI
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * command-line utility
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * configuration file (e.g. INI) 
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * library APIs
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * IPC (inter-process communication, e.g. dbus)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * REST API
    * not important
    * slightly important
    * moderately important
    * important
    * very important
* At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access
  * for debugging/testing purposes
  * to bypass standard configuration system/library/API
  * if configuration is unlikely to be changed by a user
  * if environment semantics are needed (inherit changed environment at fork)
  * even when it is used inside a loop, e.g.:for (int i = 0; i < K; ++i) getenv("HOME");
  * even when it is in a function which should be lightweight
  * even in multi-threaded code
  * I do not use it (use other to write why)
* Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?
  * via a web interface
  * via ssh
  * in groups/clusters of devices with similar configuration (e.g. multiple instances of web servers)
  * in non-clustered devices with independent configurations
  * in a single computer (e.g. configuring your home server)
  * not interested
* You want to configure a FLOSS application.How important are the following ways for you?
  * documentation shipped with the applications
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * configuration examples shipped with the applications
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * website of the applications
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * google, stackoverflow… (looking for my problem)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * wiki, tutorials… (looking for complete solutions)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * ask colleagues and friends
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * look into the source code
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * look into the configuration specification (e.g. XSD)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * use UI that will help me
    * not important
    * slightly important
    * moderately important
    * important
    * very important
* What is your preferred way to backup, sync or share configurations?
  * binary files in git repository or other VCS
  * configuration files in git repository or other VCS
  * timed or scripted trough file system backup (e.g. rsync)
  * manual sync of selected folder online, on external or network media
  * synchronization services (e.g. chrome synchronization, dropbox)
  * I do not backup, sync or share configurations
* Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)
  * must be lightweight and efficient
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must be available anywhere and anytime (e.g. package managers or platforms)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must be a trivial API (e.g. like getenv)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must support context-features (e.g. firefox profiles, reconfiguration when in power-saving mode)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must support integration of system configuration
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must support signatures and encryption (e.g. to protect passwords)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must support (custom) human-readable configuration formats (e.g. XML/JSON/YAML)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must support plugins for my use-cases (e.g. custom validation)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * migration must be effortless
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * should implement the APIs I already use (e.g. GSettings)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * community must be active and supportive
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * must be well-maintained (bugs are fixed promptly)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * should be usable without library installed on target system (e.g. header-only)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
  * other: (Please name it after making a selection)
    * not important
    * slightly important
    * moderately important
    * important
    * very important
