require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "page_titleの文字列が空の場合" do
      let(:page_title) { "" }

      it "タイトルがBIGBAG Storeとなること" do
        expect(full_title(page_title)).to eq "BIGBAG Store"
      end
    end

    context "page_titleが存在しない場合" do
      let(:page_title) { nil }

      it "タイトルがBIGBAG Storeとなること" do
        expect(full_title(page_title)).to eq "BIGBAG Store"
      end
    end

    context "page_titleに文字列がある場合" do
      let(:page_title) { "test" }

      it "タイトルがtest - BIGBAG Storeとなること" do
        expect(full_title(page_title)).to eq "test - BIGBAG Store"
      end
    end
  end
end
