class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.14.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.14.0"
  sha256 "9d1834d8bb5442167738b6236e007a67dadf037bd36c29f5da2eac26ec220589"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.14.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "01091c6b20ced2371355e90ee8085e1b03cbd034d38f9b262fd4dd14c6d74a7d"
  end

  def install
    mkdir_p libexec
    mv "zv", "\#{libexec}/zv"
    chmod 0755, "\#{libexec}/zv"
    mkdir_p bin
    ln_s "\#{libexec}/zv", "\#{bin}/zv"
  end

  def caveats
    <<~EOS
      zv is installed at \#{libexec}/zv with a symlink at \#{bin}/zv.

      Data directory: ~/.local/share/zv
      Run  to configure your shell environment.
    EOS
  end

  test do
    assert_match "zv", shell_output("\#{bin}/zv --version")
  end
end
