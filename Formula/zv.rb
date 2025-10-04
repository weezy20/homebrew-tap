class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.2.1/zv-aarch64-apple-darwin.tar.xz"
      sha256 "2285b9d07a3250432bca7c51c3832d9d511626a0f330e81cca444ea60b685c8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.2.1/zv-x86_64-apple-darwin.tar.xz"
      sha256 "06109bf14f7fa1fc56b12d1d3920a99a761786e12f6dc960086edc4fe44a55ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.2.1/zv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "691c1d249f936af0cc37643cf6b51a4e5b267ac001084b19f512fb6049217aa9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.2.1/zv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9fdf36de92f6eba82c42de42bc45abe1ef97e0521742bb51cfe52765b7ed834f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "zv" if OS.mac? && Hardware::CPU.arm?
    bin.install "zv" if OS.mac? && Hardware::CPU.intel?
    bin.install "zv" if OS.linux? && Hardware::CPU.arm?
    bin.install "zv" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
