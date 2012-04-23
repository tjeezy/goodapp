class BasicFeedbacksController < ApplicationController
  def create
    @app = App.find(params[:app_id])
    @basic_feedback = BasicFeedback.new(params[:basic_feedback])
    @basic_feedback.app_id = @app.id
    @basic_feedback.user_id = current_user.id
    if @basic_feedback.save
      redirect_to @app, :notice => "Successfully updated your feedback for #{@app.name}."
    else
      flash.now.alert = "Your feedback was not properly updated."
      render @app
    end
  end

  def update
    @app = App.find(params[:app_id])
    # TODO clean up
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
    @basic_feedback = BasicFeedback.find_by_user_id_and_app_id(current_user, @app)
    if @basic_feedback.update_attributes(params[:basic_feedback])
      redirect_to @app, :notice => "Successfully updated your feedback for #{@app.name}."
    else
      flash.now.alert = "Your feedback was not properly updated."
      render 'apps/show'
    end
  end
end