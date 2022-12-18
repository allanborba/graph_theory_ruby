require "domain/core/vertex"

describe Vertex do
  describe "#initialize" do
    context "when argument is nil" do
      it {expect{described_class.new(nil)}.to raise_error(ArgumentError, "Label must be a String")}
    end

    context "when argument is empty" do
      it {expect{described_class.new("  ")}.to raise_error(ArgumentError, "Blank label not allowed")}
    end

    context "when argument is valid" do
      it {expect{described_class.new("A")}.not_to raise_error}
    end
  end

  describe "#label" do
    context "when the argument is valid" do
      it("returns the label") {expect(described_class.new("A").label).to eq "A"}
    end
  end
end