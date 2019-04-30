module MacOS
  module Customize
    class Chrome

      def call
        create_managed_preferences_directory!
        create_plist!
        install_launch_deamon!
        launch_daemon!
      end

      private

      def create_managed_preferences_directory!
        check = Check.new good: 'Managed Preferences directory exists'

        return check.pass! if preferences_path.exist?
        return check.needs_sudo! unless Runtime.sudo_mode?
        Command::Sudo.new('/bin/mkdir', managed_preferences_path.to_s).run
        check.pass!
      end

      def create_plist!
        check = Check.new good: 'Google Chrome Policy manifest installed'

        return check.pass! if plist_path.exist? && plist_path.readable? && plist_path.read == plist_content
        return check.needs_sudo! unless Runtime.sudo_mode?
        temporary_plist.write plist_content
        temporary_plist.close
        Command::Sudo.new('/bin/cp', temporary_plist.path, plist_path).run
        temporary_plist.unlink
        Command::Sudo.new('/bin/chmod', '644', plist_path).run
        check.fixed!
        # Changing the preferences needs a reload.
        @reloadDaemon = true
      end

      def install_launch_deamon!
        check = Check.new good: 'Google Chrome Policy daemon is installed'

        unless @reloadDaemon
          return check.pass! if daemon.exists?
          return check.needs_sudo! unless Runtime.sudo_mode?
        end
        daemon.install!
        check.fixed!
      end

      def launch_daemon!
        check = Check.new good: 'Google Chrome Policy daemon is loaded'

        unless @reloadDaemon
          return check.pass! if daemon.loaded?
          return check.needs_sudo! unless Runtime.sudo_mode?
        end
        daemon.launch!
        check.fixed!
      end

      def daemon
        @daemon ||= OS::GlobalDaemon.new(
          label: 'io.github.halo.dotfiles.chrome_preferences',
          program_arguments: ['/bin/ln', '-s', plist_path.to_s, managed_preferences_path.to_s],
          run_at_load: true,
          # This is not recursive because creating the file only triggers one more creation (which doesn't change anything any more)
          watch_paths: [managed_preferences_path.to_s],
          # False means, run the job when the network goes down.
          network_state: false,
        )
      end

      # See https://stackoverflow.com/a/46857243
      def preferences_path
        Pathname.new '/Library/Preferences'
      end

      def managed_preferences_path
        Pathname.new '/Library/Managed Preferences'
      end

      def plist_path
        preferences_path.join plist_filename
      end

      def managed_plist_path
        managed_preferences_path.join plist_filename
      end

      def plist_filename
        'com.google.Chrome.plist'
      end

      def temporary_plist
        @temporary_plist ||= Tempfile.new(plist_path.basename.to_s)
      end

      # See https://sites.google.com/a/chromium.org/dev/administrators/policy-list-3
      # See chrome://policy
      def plist_content
        {
          # Extensions to be installed automatically in background
          ExtensionInstallForcelist: extension_ids,
          # Disable in-buit Flash player
          DefaultPluginsSetting: 2,
          # Disable Desktop notifications entirely
          DefaultNotificationsSetting: 2,
          # Disable creepy hardware APIs
          DefaultWebBluetoothGuardSetting: 2,
          DefaultWebUsbGuardSetting: 2,
          # Startpage.com
          DefaultSearchProviderEnabled: true,
          DefaultSearchProviderSearchURL: 'https://www.google.com/search?query={searchTerms}',
          # Disable Chromes internal password manager
          PasswordManagerEnabled: false,
          # Use system print dialog
          DisablePrintPreview: true,
          # Disable autofill
          AutofillAddressEnabled: false,
          AutofillCreditCardEnabled: false,
          # Disable Chrome sync login etc.
          BrowserSignin: 0,
          # Don't mess with DNS
          BuiltInDnsClientEnabled: false,
          # No need to check itself for default
          DefaultBrowserSettingEnabled: false,
          # Allow Developer Tools even in extensions
          DeveloperToolsAllowed: true,
          # Hide annoying stand-alone icon on startup
          HideWebStoreIcon: true,
          ShowAppsShortcutInBookmarkBar: false,
          # Disalbe first run imports
          ImportAutofillFormData: false,
          ImportBookmarks: false,
          ImportHistory: false,
          ImportHomepage: false,
          ImportSavedPasswords: false,
          ImportSearchEngine: false,
          # No predicrtive searching and link fetching
          SearchSuggestEnabled: false,
          NetworkPredictionOptions: 2,
          # Disable ofther means of phoning home
          SpellCheckServiceEnabled: false,
          UrlKeyedAnonymizedDataCollectionEnabled: false,
          # Annoying translate suggestion
          TranslateEnabled: false,
          # Reset Browser and all data on quit
          # ForceEphemeralProfiles: true,
        }.to_plist
      end

      def extension_ids
        result = []
        result << 'fhcgjolkccmbidfldomjliifgaodjagh' # Cookie AutoDelete
        result << 'aomjjhallfgjeglblehebfpbcfeobpgk' # 1Password
        result << 'dpjamkmjmigaoobjbekmfgabipmfilij' # Empty New Tab Page
        result << 'gcbommkclmclpchllfjekcdonpmejbdp' # HTTPS Everywhere
        result << 'lokpenepehfdekijkebhpnpcjjpngpnd' # Mute and skip Youtube ads (note remove)
        result
      end
    end
  end
end
