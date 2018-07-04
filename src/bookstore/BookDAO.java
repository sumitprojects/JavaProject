package bookstore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * AbstractDAO.java This DAO class provides CRUD database operations for the
 * table book in the database.
 *
 * @author www.codejava.net
 *
 */
public class BookDAO {

    private String jdbcURL;
    private String jdbcUsername;
    private String jdbcPassword;
    private Connection jdbcConnection;

    public BookDAO() {
    }

    public BookDAO(String jdbcURL, String jdbcUsername, String jdbcPassword) {
        this.jdbcURL = jdbcURL;
        this.jdbcUsername = jdbcUsername;
        this.jdbcPassword = jdbcPassword;
    }

    protected void connect() throws SQLException {
        if (jdbcConnection == null || jdbcConnection.isClosed()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        }
    }

    protected void disconnect() throws SQLException {
        if (jdbcConnection != null && !jdbcConnection.isClosed()) {
            jdbcConnection.close();
        }
    }

    public boolean insertBook(Book book) throws SQLException {
        String sql = "INSERT INTO book (title, author, price) VALUES (?, ?, ?)";
        connect();

        boolean rowInserted;
        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setFloat(3, book.getPrice());
            rowInserted = statement.executeUpdate() > 0;
        }
        disconnect();
        return rowInserted;
    }

    public List<Book> listAllBooks() throws SQLException {
        List<Book> listBook = new ArrayList<>();

        String sql = "SELECT * FROM book";

        connect();

        try (Statement statement = jdbcConnection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("book_id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                float price = resultSet.getFloat("price");

                Book book = new Book(id, title, author, price);
                listBook.add(book);
            }

        }

        disconnect();

        return listBook;
    }

    public boolean deleteBook(Book book) throws SQLException {
        String sql = "DELETE FROM book where book_id = ?";

        connect();

        boolean rowDeleted;
        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setInt(1, book.getId());
            rowDeleted = statement.executeUpdate() > 0;
        }
        disconnect();
        return rowDeleted;
    }

    public boolean updateBook(Book book) throws SQLException {
        String sql = "UPDATE book SET title = ?, author = ?, price = ? WHERE book_id = ?";
        connect();

        boolean rowUpdated;
        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setFloat(3, book.getPrice());
            statement.setInt(4, book.getId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        disconnect();
        return rowUpdated;
    }

    public Book getBook(int id) throws SQLException {
        Book book = null;
        String sql = "SELECT * FROM book WHERE book_id = ?";
        connect();

        try (PreparedStatement statement = jdbcConnection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String title = resultSet.getString("title");
                    String author = resultSet.getString("author");
                    float price = resultSet.getFloat("price");

                    book = new Book(id, title, author, price);
                }
            }
        }

        return book;
    }
}
