class HappinessChecker
  def self.calculate
    new.calculate
  end

  def calculate
    HappinessSnapshot.create(
      percent_happy: percent_happy,
      sad_reasons: sad_reasons
    )
  end

  private

  def percent_happy
    return 1.0 if (Pterosaur.count < 1) or (total_unhappy < 1)
    (total_unhappy.to_f / Pterosaur.count.to_f)
  end

  def sad_reasons
    {
      too_few_play_dates: lonely_pts.count,
      unvaccinated: unvaccinated_pts.count
    }
  end

  def unvaccinated_pts
    return @_unvaccinated_pts if defined?(@_unvaccinated_pts)

    required_vaccines = VaccinationRecord::REQUIRED_VACCINATIONS
    current = VaccinationRecord
      .where(name: required_vaccines)
      .where("vaccination_records.due_date >= ?", start_of_week)
      .where("vaccination_records.pterosaur_id = pterosaurs.id")
      .select("COUNT(DISTINCT vaccination_records.name)")

    @_unvaccinated_pts = Pterosaur.
      where("(#{current.to_sql}) < ?", required_vaccines.size)
  end

  def start_of_week
    Time.now.beginning_of_week
  end

  def lonely_pts
    return @_lonely_pts if defined?(@_lonely_pts)

    end_of_week = start_of_week.end_of_week

    @_lonely_pts = Pterosaur.where("(#{
      PlayDate.
        joins("INNER JOIN play_dates_pterosaurs pp ON pp.play_date_id = play_dates.id").
        where(start_time: 7.days.ago..Time.current).
        where("pp.pterosaur_id = pterosaurs.id").
        select("COUNT(*)").to_sql
    }) < 2").where.not(id: unvaccinated_pts.pluck(:id))
  end

  def total_unhappy
    # add new kinds of unhappiness here
    lonely_pts.count + unvaccinated_pts.count
  end
end
