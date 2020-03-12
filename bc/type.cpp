/*
 * Copyright 2019-2020 Hans-Kristian Arntzen for Valve Corporation
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 */

#include "type.hpp"
#include "context.hpp"
#include "cast.hpp"
#include <assert.h>

namespace LLVMBC
{
PointerType::PointerType(Type *type, uint32_t addr_space)
		: Type(type->getContext(), TypeID::Pointer), contained_type(type), address_space(addr_space)
{
}

PointerType *PointerType::get(Type *pointee, unsigned addr_space)
{
	auto &context = pointee->getContext();
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
	{
		if (type->getTypeID() == TypeID::Pointer)
		{
			auto *pointer_type = cast<PointerType>(type);
			if (pointer_type->getAddressSpace() == addr_space && pointer_type->getElementType() == pointee)
				return pointer_type;
		}
	}

	auto *type = context.construct<PointerType>(pointee, addr_space);
	cache.push_back(type);
	return type;
}

unsigned PointerType::getAddressSpace() const
{
	return address_space;
}

Type *PointerType::getElementType() const
{
	return contained_type;
}

ArrayType::ArrayType(Type *type, uint64_t elements_)
		: Type(type->getContext(), TypeID::Array), contained_type(type), elements(elements_)
{
}

ArrayType *ArrayType::get(Type *element, uint64_t size)
{
	auto &context = element->getContext();
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
	{
		if (type->getTypeID() == TypeID::Array)
		{
			auto *array_type = cast<ArrayType>(type);
			if (array_type->getArrayNumElements() == size && array_type->getArrayElementType() == element)
				return array_type;
		}
	}

	auto *type = context.construct<ArrayType>(element, size);
	cache.push_back(type);
	return type;
}

VectorType::VectorType(LLVMBC::LLVMContext &context, unsigned vector_size_, LLVMBC::Type *type)
	: Type(context, TypeID::Vector), element_type(type), vector_size(vector_size_)
{
}

unsigned VectorType::getVectorSize() const
{
	return vector_size;
}

Type *VectorType::getElementType() const
{
	return element_type;
}

VectorType *VectorType::get(unsigned vector_size, Type *element)
{
	auto &context = element->getContext();
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
	{
		if (type->getTypeID() == TypeID::Vector)
		{
			auto *vector_type = cast<VectorType>(type);
			if (vector_type->getVectorSize() == vector_size && vector_type->getElementType() == element)
				return vector_type;
		}
	}

	auto *type = context.construct<VectorType>(context, vector_size, element);
	cache.push_back(type);
	return type;
}

uint64_t Type::getArrayNumElements() const
{
	assert(type_id == TypeID::Array);
	return cast<ArrayType>(this)->elements;
}

Type *Type::getArrayElementType() const
{
	assert(type_id == TypeID::Array);
	return cast<ArrayType>(this)->contained_type;
}

Type *Type::getPointerElementType() const
{
	assert(type_id == TypeID::Pointer);
	return cast<PointerType>(this)->getElementType();
}

StructType::StructType(LLVMContext &context, std::vector<Type *> member_types_)
		: Type(context, TypeID::Struct), member_types(std::move(member_types_))
{
}

unsigned StructType::getNumElements() const
{
	return member_types.size();
}

Type *StructType::getElementType(unsigned N) const
{
	assert(N < member_types.size());
	return member_types[N];
}

StructType *StructType::get(std::vector<Type *> member_types)
{
	assert(!member_types.empty());
	auto &context = member_types.front()->getContext();
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
	{
		if (type->getTypeID() == TypeID::Struct)
		{
			auto *struct_type = cast<StructType>(type);
			if (struct_type->getNumElements() == member_types.size())
			{
				bool equal = true;
				unsigned count = member_types.size();
				for (unsigned i = 0; i < count; i++)
				{
					if (member_types[i] != struct_type->getElementType(i))
					{
						equal = false;
						break;
					}
				}

				if (equal)
					return struct_type;
			}
		}
	}

	auto *type = context.construct<StructType>(context, std::move(member_types));
	cache.push_back(type);
	return type;
}

FunctionType::FunctionType(LLVMContext &context, Type *return_type_, std::vector<Type *> argument_types_)
	: Type(context, TypeID::Function), return_type(return_type_), argument_types(std::move(argument_types_))
{
}

unsigned FunctionType::getNumParams() const
{
	return unsigned(argument_types.size());
}

Type *FunctionType::getParamType(unsigned index) const
{
	assert(index < argument_types.size());
	return argument_types[index];
}

Type *FunctionType::getReturnType() const
{
	return return_type;
}

IntegerType::IntegerType(LLVMContext &context, uint32_t width_)
	: Type(context, TypeID::Int), width(width_)
{
}

uint32_t IntegerType::getBitWidth() const
{
	return width;
}

Type::Type(LLVMContext &context_, TypeID type_id_)
	: context(context_), type_id(type_id_)
{
}

TypeID Type::getTypeID() const
{
	return type_id;
}

Type *Type::getIntTy(LLVMContext &context, uint32_t width)
{
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
		if (type->getTypeID() == TypeID::Int && cast<IntegerType>(type)->getBitWidth() == width)
			return type;

	auto *type = context.construct<IntegerType>(context, width);
	cache.push_back(type);
	return type;
}

Type *Type::getTy(LLVMContext &context, TypeID id)
{
	auto &cache = context.get_type_cache();
	for (auto *type : cache)
		if (type->getTypeID() == id)
			return type;

	auto *type = context.construct<Type>(context, id);
	cache.push_back(type);
	return type;
}

Type *Type::getVoidTy(LLVMContext &context)
{
	return getTy(context, TypeID::Void);
}

Type *Type::getHalfTy(LLVMContext &context)
{
	return getTy(context, TypeID::Half);
}

Type *Type::getFloatTy(LLVMContext &context)
{
	return getTy(context, TypeID::Float);
}

Type *Type::getDoubleTy(LLVMContext &context)
{
	return getTy(context, TypeID::Double);
}

Type *Type::getLabelTy(LLVMContext &context)
{
	return getTy(context, TypeID::Label);
}

Type *Type::getMetadataTy(LLVMContext &context)
{
	return getTy(context, TypeID::Metadata);
}

Type *Type::getInt1Ty(LLVMContext &context)
{
	return getIntTy(context, 1);
}

Type *Type::getInt8Ty(LLVMContext &context)
{
	return getIntTy(context, 8);
}

Type *Type::getInt16Ty(LLVMContext &context)
{
	return getIntTy(context, 16);
}

Type *Type::getInt32Ty(LLVMContext &context)
{
	return getIntTy(context, 32);
}

Type *Type::getInt64Ty(LLVMContext &context)
{
	return getIntTy(context, 64);
}

bool Type::isIntegerTy() const
{
	return type_id == TypeID::Int;
}

bool Type::isFloatingPointTy() const
{
	return type_id == TypeID::Half ||
	       type_id == TypeID::Float ||
	       type_id == TypeID::Double;
}

LLVMContext &Type::getContext()
{
	return context;
}
}