class HomeController < ApplicationController
  def main
    api_request.on_complete do |response|
      data = JSON.parse(response.body)
      total = 0.0
      coke = 0

      data.each do |entry|
        total += 1

        if entry["message"].include?("coke") || entry["message"].include?("coca-cola") || entry["message"].include?("diet-cola")
          coke += 1
        end

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

      @updates = Update.all
      @coke_percentage = coke / total * 100
    end
  end

  def show
    @update = Update.find(params[:id])
  end

  private

  def api_request
    Faraday.get("https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json")
  end

  def save_update
  end
end
