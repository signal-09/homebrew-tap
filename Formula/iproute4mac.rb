class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.2.0"
  url "https://files.pythonhosted.org/packages/3f/23/4e90b20364d686647044cf2d7e573f6444e0e7bee8366b5af2ba1c4fa656/iproute4mac-0.2.0.tar.gz"
  sha256 "89e8a07b1493bb567f73c091260f7fa952d6212c4bbe01da0639fa03667fe111"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2", "iproute2mac", because: "both provide same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
