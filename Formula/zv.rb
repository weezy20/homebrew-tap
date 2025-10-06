class Zv < Formula
  desc "Ziglang Version Manager and Project Starter"
  homepage "https://github.com/weezy20/zv"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.3.0/zv-aarch64-apple-darwin.tar.gz"
      sha256 "3db49c75b49efe2144a7aa9d4de1e76fed408cc10dc95ba1bba071d8753b5ffc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.3.0/zv-x86_64-apple-darwin.tar.gz"
      sha256 "5ad119aeb5d05c8b66cd14c94cec5ba681d2843c35a537af4778f94e5da145a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/weezy20/zv/releases/download/v0.3.0/zv-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "57a2adc22244d1d17a254500e1d3686fe513d7090820277e45a0c0209111fc06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/weezy20/zv/releases/download/v0.3.0/zv-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "165860b13262a460a7068e923fbe6d28c72b217740e70d907b8a03e3ff35c87d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
