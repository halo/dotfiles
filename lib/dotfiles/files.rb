module Dotfiles
  class Files
    def call
      local_paths.each do |relative_path|
        link = remote.join(".#{relative_path}")

        Connect.call caption: "#{link.relative_path_from(remote)}",
                     file: local.join(relative_path),
                     link: link
      end
    end

    private

    def local_paths
      Dotfiles.dotfiles.glob('**/*').select(&:file?).map do |path|
        path.relative_path_from(local)
      end
    end

    def local
      Dotfiles.dotfiles
    end

    def remote
      Pathname.new('~').expand_path
    end
  end
end
