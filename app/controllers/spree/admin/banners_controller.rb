module Spree
  module Admin
    class BannersController < Spree::Admin::ResourceController
      before_action :load_data, except: [:index]

      def update_positions
        ActiveRecord::Base.transaction do
          params[:positions].each do |id, index|
            Spree::Banner.where(id: id).update_all(position: index)
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_banners_url }
          format.js { render text: 'Ok' }
        end
      end

      protected

      def load_data
        @taxons = Spree::Taxon.order(:name)
        @products = Spree::Product.active.order(:name)
        @banner_categories = Spree::BannerCategory.order(:name)
      end

      def collection
        return @collection if defined?(@collection)
        params[:q] = {} if params[:q].blank?

        @collection = super
        @search = @collection.ransack(params[:q])
        @collection = @search.result(distinct: true).
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:admin_products_per_page])

        @collection
      end
    end
  end
end
