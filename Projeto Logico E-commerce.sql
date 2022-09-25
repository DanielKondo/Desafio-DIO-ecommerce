-- Criação do banco de dados para o cenário de e-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela de cliente

CREATE TABLE clients(
			idClient int auto_increment primary key,
            Fname varchar(20),
            Minit char(1),
            Lname varchar(20),
            document varchar(15) not null,
            documentType enum('CPF', 'CNPJ') default 'CPF',
            adress varchar(45),
            birthDate date,
            constraint unique_doc_client unique (document)
);

-- criar tabela de produto

CREATE TABLE product(
			idProduct int auto_increment primary key,
            Pname varchar(20) not null,
			category enum('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimento') not null,
            reviewScore float default 0,
            size varchar(10)
);


-- criar tabelas de pagamento e de cartão

CREATE TABLE payment(
			idClient int,
            idPayment int unique,
            typePayment enum('Boleto', 'Cartão', 'Dois Cartões'),
            primary key (idClient, idPayment),
			constraint fk_payment foreign key(idClient) references clients(idClient)
);

CREATE TABLE card(
			idCartão int,
            idPayment int,
            cardNumber char(16),
            expirationDate date,
            ownerName varchar(45),
            primary key (idCartão, idPayment),
            constraint fk_payment_card foreign key(idPayment) references payment(idPayment)
);

-- criar tabela de pedido
CREATE TABLE orders(
			idOrder int auto_increment primary key,
            idClient int,
            orderStatus enum('Em andamento', 'Processando', 'Enviando', 'Entregue') not null default 'Processando',
            orderDescription varchar(225),
            sendValue float default 10,
            constraint fk_order_client foreign key (idClient) references clients(idClient)
);

CREATE TABLE sendingStatus(
			track_code int primary key,
            idOrder int,
            sendStatus enum('A Caminho', 'Entregue'),
            constraint fk_send_status foreign key (idOrder) references orders(idOrder)
);


-- criar tabela de estoque

CREATE TABLE productStorage(
			idStorage int auto_increment primary key,
            storageLocation varchar(255)
);

-- criar tabela de fornecedor
CREATE TABLE supplier(
			idSupplier int auto_increment primary key,
			socialName varchar(255) not null,
            CNPJ char(15) not null,
            contact char(11) not null,
            constraint unique_supplier unique(CNPJ)
);

-- criar tabela de vendedor terceiro
CREATE TABLE seller(
			idSeller int auto_increment primary key,
			socialName varchar(255) not null,
            CNPJ char(15) not null,
            contact char(11) not null,
            constraint unique_supplier unique(CNPJ)
);

-- tabelas de relacionamento

CREATE TABLE productSeller(
			idSeller int,
            idProduct int,
            quantity int default 1,
            primary key (idSeller, idProduct),
            constraint fk_product_seller foreign key (idSeller) references seller(idSeller),
            constraint fk_product_product foreign key (idProduct) references product(idProduct)      
);

CREATE TABLE productOrder(
			idOrder int,
            idProduct int,
            quantity int default 1,
            proStatus enum('Disponível', 'Sem Estoque') default 'Disponível',
            primary key (idOrder, idProduct),
            constraint fk_product_order foreign key (idOrder) references orders(idOrder),
            constraint fk_product_orproduct foreign key (idProduct) references product(idProduct)      
);

CREATE TABLE productSupplier(
			idSupplier int,
            idProduct int,
            quantity int default 1,
            primary key (idSupplier, idProduct),
            constraint fk_product_supplier foreign key (idSupplier) references supplier(idSupplier),
            constraint fk_product_suproduct foreign key (idProduct) references product(idProduct)      
);

CREATE TABLE productStorage(
			idStorage int,
            idProduct int,
            quantity int default 1,
            primary key (idStorage, idProduct),
            constraint fk_product_storage foreign key (idStorage) references supplier(idStorage),
            constraint fk_product_stproduct foreign key (idProduct) references product(idProduct)      
);
show tables;