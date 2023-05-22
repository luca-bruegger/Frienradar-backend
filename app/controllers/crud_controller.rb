# Abstract controller providing basic CRUD actions.
#
# Some enhancements were made to ease extensibility.
# The current model entry is available in the view as an instance variable
# named after the +model_class+ or in the helper method +entry+.
# Several protected helper methods are there to be (optionally) overriden by
# subclasses.
# With the help of additional callbacks, it is possible to hook into the
# action procedures without overriding the entire method.
class CrudController < ListController
  class_attribute :permitted_attrs, :nested_models

  # GET /entries/1
  def show(options = {})
    authorize entry
    render_entry({ include: '*' }.merge(options[:render_options] || {}))
  end

  # POST /entries
  def create(options = {})
    build_entry
    authorize entry
    if entry.save
      render_entry({ status: :created }
                     .merge(options[:render_options] || {}))
    else
      render_errors
    end
  end

  # PATCH/PUT /entries/1
  def update(options = {})
    authorize entry
    entry.attributes = model_params
    if entry.save
      render_entry(options[:render_options])
    else
      render_errors
    end
  end

  # DELETE /entries/1
  def destroy(_options = {})
    authorize entry
    if entry.destroy
      head :no_content
    else
      render_errors
    end
  end

  private

  def entry
    instance_variable_get(:"@#{model_identifier}") ||
      instance_variable_set(:"@#{model_identifier}", fetch_entry)
  end

  def fetch_entry
    model_scope.find(params.fetch(:id))
  end

  def build_entry
    instance_variable_set(:"@#{model_identifier}", model_scope.new(model_params))
  end

  def render_entry(options = {})
    render json: {
      data: model_serializer.new(entry).serializable_hash[:data][:attributes]
    }.merge(options || {}), status: :ok
  end

  def render_errors
    render json: {
      message: entry.errors.full_messages.to_sentence
    }, status: :unprocessable_entity
  end

  def model_params
    params.require(model_identifier).permit(permitted_attrs)
  end

  def permitted_param?(attribute_name)
    permitted_attrs.map(&:to_s).include?(attribute_name)
  end

  def model_identifier
    model_class.model_name.param_key
  end
end