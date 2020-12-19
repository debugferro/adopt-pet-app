module RequestHelper
  def display_text(request, all_requests)
    if request.finished
      "Your request to #{request.pet.user.first_name} #{request.pet.user.last_name} to adopt #{request.pet.name} was accepted!"
    elsif all_requests.where(pet_id: request.pet.id, finished: true).first.present?
      "Your request to #{request.pet.user.first_name} #{request.pet.user.last_name} to adopt #{request.pet.name} was not accepted!"
    else
      "You requested #{request.pet.user.first_name} #{request.pet.user.last_name} to adopt #{request.pet.name}"
    end
  end

  def request_finished?(request, all_requests)
    all_requests.where(pet_id: request.pet.id, finished: true).first.present?
  end

  def display_last_message(request)
    if request.messages.last
      sender = "#{request.messages.last.user.first_name} #{request.messages.last.user.last_name}"
      "#{sender}: #{request.messages.last.content}"
    else
      "No one said anything yet, don't be shy! :("
    end
  end
end
