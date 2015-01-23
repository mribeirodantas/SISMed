-- SISMed Seed
USE [SISMed]
GO

INSERT INTO [dbo].[TiposDeUsuario] (Nome) VALUES ('Atendente'), ('Médico'), ('Gestor'), ('Administrador')
GO

INSERT INTO [dbo].[EstadosCivis] (Nome) VALUES ('Solteiro(a)'), ('Casado(a)'), ('Divorciado(a)'), ('Víuvo(a)')
GO

INSERT INTO [dbo].[DiasDaSemana] (Nome) VALUES ('Domingo'), ('Segunda-feira'), ('Terça-feira'), ('Quarta-feira'), ('Quinta-feira'), ('Sexta-feira'), ('Sábado')
GO

ALTER TABLE [dbo].[Pessoas_Usuario]
ADD UNIQUE (Email)
GO

INSERT INTO [dbo].[Pessoas] (Nome, Sobrenome, DataNascimento, CPF, RG, Sexo, EstadoCivilId, TelefoneCelular, TelefoneResidencial) VALUES ('Administrador', 'SISMed', '1997-01-01', '123.456.789-10', '123.456.789', 'M', 1, '(11) 1111-1111', '(11) 1111-1111')
GO

INSERT INTO [dbo].[Pessoas_Usuario] (Email, Senha, TipoDeUsuarioId, Id) VALUES ('sismed@sismed.com', 'be2f93326410585f5c3306ca858f500ef27f296d23afaa7cfd6149ef22d09b652ce326051554057db0817854d6689cc7cc4dfba2146b0a7534c0a7b3e6341c83', 4, SCOPE_IDENTITY())
GO

INSERT INTO [dbo].[Medicos] (UsuarioId, Usuario_Id) VALUES (1, 1)
GO