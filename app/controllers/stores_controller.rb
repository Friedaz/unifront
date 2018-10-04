class StoresController < InheritedResources::Base


  private

    def store_params
      params.require(:store).permit(:name, :description, :logo, :user_id)
    end
end

