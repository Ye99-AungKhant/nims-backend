// auditLogModel.js
import prisma from "./../config/prisma.js";
// AuditLogService for handling audit log operations using Prisma

class AuditLogService {
  /**
   * Create a new audit log entry
   * @param {Object} params
   * @param {number|null} params.user_id - User ID who performed the action
   * @param {string} params.action - Action performed (e.g., CREATE, UPDATE, DELETE)
   * @param {string} params.table_name - Table/model name affected
   * @param {number|null} params.record_id - Primary key of the affected record
   * @param {string|null} params.ip_address - IP address of the user
   * @returns {Promise<Object>} The created audit log entry
   */
  static async create({
    user_id = null,
    action,
    table_name,
    record_id = null,
    ip_address = null,
  }) {
    return prisma.auditLog.create({
      data: {
        user_id,
        action,
        table_name,
        record_id,
        ip_address,
      },
    });
  }

  /**
   * Get audit logs with optional filters
   * @param {Object} filter - Filter options
   * @returns {Promise<Array>} List of audit logs
   */
  static async findMany(filter = {}) {
    return prisma.auditLog.findMany({
      where: filter,
      orderBy: { timestamp: "desc" },
    });
  }

  /**
   * Get a single audit log by ID
   * @param {number} id - Audit log ID
   * @returns {Promise<Object|null>} Audit log entry or null
   */
  static async findById(id) {
    return prisma.auditLog.findUnique({
      where: { id },
    });
  }

  /**
   * Delete audit logs older than a certain date (for maintenance)
   * @param {Date} beforeDate - Delete logs before this date
   * @returns {Promise<number>} Number of deleted records
   */
  static async deleteOlderThan(beforeDate) {
    const result = await prisma.auditLog.deleteMany({
      where: {
        timestamp: {
          lt: beforeDate,
        },
      },
    });
    return result.count;
  }
}

export default AuditLogService;
