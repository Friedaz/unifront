class StoresController < InheritedResources::Base
include CurrentCart
  before_action :set_cart

  private

    def store_params
      params.require(:store).permit(:name, :description, :logo, :user_id)
    end
end

