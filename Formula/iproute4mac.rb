class Iproute4mac < Formula
  include Language::Python::Virtualenv

  desc "iproute for Mac"
  homepage "https://github.com/signal-09/iproute4mac"
  version "0.1.5"
  url "https://files.pythonhosted.org/packages/5d/76/5b8547384cdec891d1e9af699318769b5df5d2de55651556962e351b220d/iproute4mac-0.1.5.tar.gz"
  sha256 "1b5a8b85cb73e8590788ea7b488f502d474a7f9d90b23fd7d4346cdc04438c2c"
  head "https://github.com/signal-09/iproute4mac.git", branch: "master"

  depends_on :macos
  depends_on "python@3.12"

  conflicts_with "iproute2mac", because: "iproute2mac provides same executables"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/ip -Version"
  end
end
