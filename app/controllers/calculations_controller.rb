class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    # while condition
    #
    #
    #   while @text
    #
    #   end
    # end

  #  text_without_spaces = @text.gsub(" ", "").length
    text_array = @text.downcase.split(" ")
    occurence_count = 0
    text_array.each do |word|
      if word == @special_word.downcase.strip
        occurence_count += 1
      end
    end

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").gsub("\r\n", "").length

    @word_count =text_array.count
    @occurrences = occurence_count



    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    #Formula:::   M = P [ i(1 + i)^n ] / [ (1 + i)^n – 1]
    # P = L [c(1 + c)n] / [(1 + c)n - 1]


    monthly_interest = @apr*0.01 / 12
    total_months = @years * 12




    @monthly_payment = @principal *
     (monthly_interest * (1 + monthly_interest)**total_months) /
     ((1 + monthly_interest)**total_months - 1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
    end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================








  # Below is what I misinterpretted the desire of the clock to be, which is very unfortunate considering it was considerably harder to create than what is actually desired. Had I know I could just use the grader to see what the submission should be, I could have saved myself 3 hours.
  #  total_secs = (@ending-@starting).to_i
    # total_mins, total_hours, total_days, total_weeks, total_years = 0,0,0,0,0
    #
    #
    #
  # if  total_secs >= 60
  #   total_mins = total_secs/60
  #   if total_mins >= 60
  #       total_hours = total_mins/60
  #     if total_hours >= 24
  #       total_days = total_hours/24
  #       if total_days >= 7
  #         total_weeks = total_days/7
  #         if total_weeks >= 52
  #             total_years = total_weeks/52
  #         end
  #       end
  #     end
  #   end
  # end
  #
  #
  #   @seconds = total_secs % 60
  #   @minutes = total_mins % 60
  #   @hours = total_hours % 24
  #   @days = total_days % 7
  #   @weeks = total_weeks % 52
  #   @years = total_years

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

######## Work Below #################






######## Inputs Below ###############

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

        midpoint = @count/2

        if @count.even?
          low_median_number = midpoint - 0.5
          high_median_number = midpoint + 0.5
          @median = (@sorted_numbers[low_median_number] + @sorted_numbers[high_median_number])/2
        else
          @median = @sorted_numbers[midpoint]
        end



    @sum = @numbers.sum

    @mean = @sum/@count

    deviations = []
    @numbers.each do |num|
      deviations.push((num-@mean) **2)
    end

    @variance = deviations.sum / @count


    @standard_deviation = @variance ** 0.5

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }


    @mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
