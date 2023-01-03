# frozen_string_literal: true

module HasToZip
  extend ActiveSupport::Concern

  def to_zip = BagItStream.new(bag_it_stream_args).rack_body

  private

  # HINT: [ { files: { "file_name1" => "file_path1", "file_name2" => StringIO.new("file_content2") },
  #         bag_path: "path_to_bag_does_not_need_to_exists_yet_but_if_it_does_clean_it_up_yourself",
  #         cache_bag: true} ]
  def bag_it_stream_args
    # HINT: iterate over publications with the assigned number of threads.
    Parallel.map(publications, in_threads: ENV.fetch("BAG_IT_STREAM_THREADS").to_i) do |publication|
      # HINT: synchronizes thread access to a limited number of database connections.
      Publication.connection_pool.with_connection do
        BagItStreamArgBuilder.new(publication).build
      end
    end
  end
end
