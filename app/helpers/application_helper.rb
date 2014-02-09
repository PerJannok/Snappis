module ApplicationHelper

	def admin?
		if current_user.present?
			current_user.name == "Per Jannok"
		end
	end

end
