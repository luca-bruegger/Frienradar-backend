# Abstract controller providing a basic list action.
# The loaded model entries are available in the view as an instance variable
# named after the +model_class+ or by the helper method +entries+.
#
# The +index+ action lists all entries of a certain model and provides
# functionality to search and sort this list.
# Furthermore, it remembers the last search and sort parameters after the
# user returns from a displayed or edited entry.
class ListController < ApplicationController

  delegate :model_class, :model_identifier, :model_serializer, :list_serializer,
           to: 'self.class'

  class_attribute :custom_model_class

  # GET /entries
  def index(options = {})
    authorize model_class
    render json: model_serializer.new(fetch_entries, options).serializable_hash.to_json, status: :ok
  end

  protected

  def fetch_entries
    if page.present?
      model_scope.paginate(page: page)
    else
      model_scope.list
    end
  end

  private

  def model_scope
    model_class
  end

  def model_root_key
    model_class.name.underscore
  end

  def page
    params[:page].nil? ? nil : params[:page].to_i
  end

  class << self
    # The ActiveRecord class of the model.
    def model_class
      model_name = controller_path.remove('api/').classify.remove('::')
      @model_class ||= custom_model_class || model_name.constantize
    end

    # The identifier of the model used for form parameters.
    # I.e., the symbol of the underscored model name.
    def model_identifier
      @model_identifier ||= model_class.model_name.param_key
    end

    def list_serializer
      model_serializer
    end

    def model_serializer
      @model_serializer ||= "#{model_class.name}Serializer".constantize
    end
  end

end