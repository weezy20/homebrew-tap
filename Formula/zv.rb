class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.10.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.10.0"
  sha256 "5134bf9d575f5742e5a86e946253e593f359beb1a4f2691ffbf6e90b605fcf4d"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.10.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "8085b8ce2bf1b2dee7ba7f32777ff9061dbea1be761a936c99cc6831896c62b1"
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
