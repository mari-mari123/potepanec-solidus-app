require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "page_titleの文字列が空の場合" do
      it "タイトルがBIG BAG Storeとなること" do
        page_title = ""
        expect(full_title(page_title)).to eq "BIG BAG Store"
      end
    end

    context "page_titleが存在しない場合" do
      it "タイトルがBIG BAG Storeとなること" do
        page_title = nil
        expect(full_title(page_title)).to eq "BIG BAG Store"
      end
    end

    context "page_titleに文字列がある場合" do
      it "タイトルがtest - BIG BAG Storeとなること" do
        page_title = "test"
        expect(full_title(page_title)).to eq "test - BIG BAG Store"
      end
    end
  end
end
