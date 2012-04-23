class AppsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @app = App.find(params[:id])
    @goods = {:g_speed => 'Fast and reliable',
      :g_ease => 'Easy to use',
      :g_updates => 'Updates are consistent',
      :g_on_offline => 'Works on and off line',
      :g_battery => 'Low battery usage',
      :g_personalize => 'Ability to personalize',
      :g_location_services => 'Uses my location nicely',
      :g_performs => 'Performs as expected',
      :g_useful => 'Interesting and useful'
    }
    @bads = {:b_battery => 'Drains battery',
      :b_ads => 'Too many advertisements',
      :b_permissions => 'Doesn\'t ask for permission',
      :b_crashes => 'Crashes often',
      :b_privacy => 'Steals private info',
      :b_sounds => 'Triggers unexpected sounds',
      :b_updates => 'Updates cause problems',
      :b_internet => 'Uses too much data',
      :b_money => 'Charges me without consent',
      :b_other_apps => 'Opens other app without consent',
      :b_location_services => 'Uses my location poorly',
      :b_overall => 'Doesn\'t perform properly'
    }
    @basic_feedbacks = BasicFeedback.find_all_by_app_id(@app.id)
    if current_user
      @basic_feedback = BasicFeedback.find_or_initialize_by_user_id_and_app_id(current_user.id, @app.id)
    end
  end

  def new
  end

  def create
    if @app.save
      # TODO use build
      owned_app = AppOwnership.create(:user_id => current_user.id, :app_id => @app.id)
      redirect_to @app, :notice => 'Successfully uploaded your App.'
    else
      flash.now.alert = 'App was not uploaded properly.'
      render 'new'
    end
  end

  def flag
  end
end
