require 'rails_helper'

RSpec.describe FileSetIndexer do
  describe 'thumbnail_path_service' do
    subject { described_class.thumbnail_path_service }
    it { is_expected.to eq IIIFThumbnailPathService }
  end
end
