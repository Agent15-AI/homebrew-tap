cask "dynamicnotch" do
  version "0.1.1"
  sha256 "7029fdcff6226278aad1b8b72b135264ee2da7076d344162293c4ba0e245078a"

  url "https://github.com/Agent15-AI/DynamicNotch/releases/download/v#{version}/DynamicNotch-#{version}.zip"
  name "DynamicNotch"
  desc "Dynamic Island for the MacBook notch"
  homepage "https://github.com/Agent15-AI/DynamicNotch"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "DynamicIsland.app"

  # The app isn't notarized (no paid Apple Developer account), so clear the download quarantine;
  # otherwise Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DynamicIsland.app"], must_succeed: false
  end

  uninstall quit: "dev.local.dynamicisland"

  zap trash: [
    "~/Library/Application Support/DynamicIsland",
    "~/Library/Preferences/dev.local.dynamicisland.plist",
  ]
end
