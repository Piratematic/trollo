class List < ApplicationRecord
  belongs_to :board

  def self.all_lists(board_id)
    List.find_by_sql(
      "SELECT *
      FROM lists AS l
      WHERE l.board_id = #{board_id}"
    )
  end

  def self.single_list(board_id, list_id)
    List.find_by_sql(["
    SELECT *
    FROM lists AS l
    WHERE l.id = ? and l.board_id = ?
    ", list_id, board_id]).first
  end

  def self.create_list(p, id)
    List.find_by_sqp(["
      INSERT INTO lists (name, board_it, created_at, updated_at)
      VALUES (:name, :board_id, :created_at, :updated_at);
    ", {
      name: p[:name],
      priority: p[:priority]
      board_id: id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    }])
  end

  def self.update_list(list_id, p)
    List.find_by_sql(["
      UPDATE lists AS l
      SET name = ?, updated_at = ?
      WHERE l.id = ?;
      ", p[:name], DateTime.now, list_id])
  end

  def self.delete_lists(list_id)
    List.find_by_sql(["
      DELETE FROM lists AS l
      WHERE l.id = ?
      ;", list_id])
  end
end
