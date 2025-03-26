'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Carts', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      user_id: {
        type: Sequelize.INTEGER,
        allowNull: false, // Make user_id non-nullable
        references: {
          model: 'Users', // Name of the table to reference
          key: 'id'       // Column in the Users table
        },
        onUpdate: 'CASCADE',
        onDelete: 'SET NULL'
      },
      is_active: {
        type: Sequelize.BOOLEAN,
        allowNull: false, // Make is_active non-nullable
        defaultValue: true // Set a default value for is_active if desired
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW // Set default value to current timestamp
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW // Set default value to current timestamp
      }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Carts');
  }
};
