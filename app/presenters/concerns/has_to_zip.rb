# frozen_string_literal: true

module HasToZip
  extend ActiveSupport::Concern

  def to_zip
    # TODO: Implement correctly.
    args = publications.map do |publication|
      @publication = publication
      publication_type = publication.model_name.element
      attachments = publication&.attachments || []
      io_files = attachments.map { |attachment| {target_file_name: "", content: nil} }
      string_io_files = [{target_file_name: "#{publication_type}.json", content: StringIO.open(to_json.to_a.join)},
        {target_file_name: "#{publication_type}.xml", content: StringIO.open(to_xml.to_a.join)}]
      # HINT: csv will be added to the array later on:
      #       {target_file_name: "#{publication_type}.csv", content: StringIO.open(mapper.to_csv)}
      bag_dir = Dir.open(create_and_return_bag_it_path)
      {files: string_io_files, bag_dir:, cache_bag: false}
    end

    BagItStream.new(args).rack_body

    # HINT: [ { files: { "file_name1" => "file_path1", "file_name2" => StringIO.new("file_content2") },
    #         bag_path: "path_to_bag_does_not_need_to_exists_yet_but_if_it_does_clean_it_up_yourself",
    #         cache_bag: true} ]
  end

  private

  def create_and_return_bag_it_path
    unix_timestamp_in_ns = (Time.current.to_r * 1000).round
    create_bag_it_path("./tmp/output/#{@publication.chemotion_id}_#{unix_timestamp_in_ns}_##{SecureRandom.uuid}")
  end

  def create_bag_it_path(path)
    FileUtils.mkpath path
    path
  end
end
