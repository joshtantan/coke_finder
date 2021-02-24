class HomeController < ApplicationController
  def index
    @updates = Update.all.order(sentiment: :desc)

    total = Update.all.count
    coke = Update.all.where("message LIKE ?", "%coke%").count
    coke += Update.all.where("message LIKE ?", "%coca-cola%").count
    coke += Update.all.where("message LIKE ?", "%diet-cola%").count
    @coke_percentage = coke / total * 100
  end

  def main
    api_request.on_complete do |response|
      data = JSON.parse(response.body)

      data.each do |entry|
        new_update = Update.new(
          source_id: entry["id"],
          user_handle: entry["user_handle"],
          sentiment: entry["sentiment"],
          followers: entry["followers"],
          message: entry["message"],
          created_at: entry["created_at"],
          updated_at: entry["updated_at"],
        )

        new_update.save!
      end

      redirect_to :action => "index"
    end
  end

  def show
    @update = Update.find(params[:id])
  end

  private

  def api_request
    Faraday.get("https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json")
  end
end
