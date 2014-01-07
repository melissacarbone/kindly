require "spec_helper"

describe ContactForm do
  describe "receipt" do
    let(:mail) { ContactForm.receipt }

    it "renders the headers" do
      mail.subject.should eq("Receipt")
      mail.to.should eq(['to@example.com'])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
