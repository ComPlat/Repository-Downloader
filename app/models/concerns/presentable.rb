module Presentable
  extend ActiveSupport::Concern

  def present_to_api
    Object.const_get("RootMappers::#{self.class.name}Mapper").from_hash mapper_hash # HINT: RootMappers::ReactionMapper
  end

  private

  def mapper_hash = mapper.to_h

  def mapper = Object.const_get("RootAdapters::#{self.class.name}To#{self.class.name}MapperAdapter").new self # HINT: RootMappers::ReactionToReactionMapperAdapter
end
