class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  url "https://github.com/weezy20/zv/releases/download/v0.11.0/zv-x86_64-apple-darwin.tar.gz"
  version "0.11.0"
  sha256 "a888b96edd95c053567c3fb9365909a1e0a876d4358b63f8fb64235ba7542c56"
  license "MIT"

  on_arm do
    url "https://github.com/weezy20/zv/releases/download/v0.11.0/zv-aarch64-apple-darwin.tar.gz"
    sha256 "1d7fefdc06b5082fa561a4cf02faec5c84fbaaf6757c1b8d17539ee36aa08b6f"
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
