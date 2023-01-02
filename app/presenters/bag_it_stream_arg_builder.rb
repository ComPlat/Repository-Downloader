# frozen_string_literal: true

class BagItStreamArgBuilder
  def initialize(publication)
    @publication = publication
  end

  def build
    @build ||= -> { # HINT: Without the lambda this would crash on second call.
      create_folder! bag_it_path
      {files:, bag_dir:, cache_bag: false}
    }.call
  end

  private

  def files = @files ||= string_io_files

  def bag_dir = @bag_dir ||= Dir.open(bag_it_path) { |dir| dir } # HINT: block is needed to automatically close Dir after returning it.

  def string_io_files
    @string_io_files ||= [
      {target_file_name: "#{publication_type}.json", content: content(json_enumerator)},
      {target_file_name: "#{publication_type}.xml", content: content(xml_enumerator)}
    ]
  end

  def content(enumerator) = StringIO.open enumerator.to_a.join

  def json_enumerator = @publication.present_to_api.to_json

  def xml_enumerator = @publication.present_to_api.to_xml

  def publication_type = @publication_type ||= @publication.model_name.element

  def bag_it_path
    @bag_it_path ||= "./tmp/output/#{@publication.chemotion_id}_#{(Time.current.to_r * 1000).round}_##{SecureRandom.uuid}"
  end

  def create_folder!(path) = FileUtils.mkpath(path)
end
