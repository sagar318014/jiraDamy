USE [taskDatabase]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/12/2022 10:05:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 8/12/2022 10:05:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [FirstName], [LastName], [CreatedAt], [UpdatedAt]) VALUES (1, N'Sagar', N'123', 1, N'Sagar', N'Gavand', NULL, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role] FOREIGN KEY([Id])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
