# frozen_string_literal: true

class BagItStreamArgBuilder
  def initialize(presenter, publication)
    @presenter = presenter
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

  def bag_dir = @bag_dir ||= Dir.open(bag_it_path)

  def string_io_files
    @string_io_files ||= [
      {target_file_name: "#{publication_type}.json", content: StringIO.open(@presenter.to_json.to_a.join)},
      {target_file_name: "#{publication_type}.xml", content: StringIO.open(@presenter.to_xml.to_a.join)}]
  end

  def publication_type = @publication_type ||= @publication.model_name.element

  def bag_it_path
    @bag_it_path ||= "./tmp/output/#{@publication.chemotion_id}_#{(Time.current.to_r * 1000).round}_##{SecureRandom.uuid}"
  end

  def create_folder!(path)
    FileUtils.mkpath(path)
  end
end
