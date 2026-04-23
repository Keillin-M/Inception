## ✅ WordPress Installation Process 

### First-time access:

1. WordPress checks:
   * Is config present?
   * Can DB be reached?
2. If not installed:
   * Asks for DB credentials
3. Writes config
4. Creates tables in DB
5. Installation complete

### After installation:

* Every page load:

  * PHP runs
  * Queries DB
  * Generates HTML
  * Sent via Nginx
