--エクシーズ・ユニット
--Xyz Unit
function c13032689.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_XYZ))
	--ATK increase
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c13032689.atkval)
	c:RegisterEffect(e1)
	--Cost replacement
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc13032689(c13032689,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c13032689.rcon)
	e2:SetOperation(c13032689.rop)
	c:RegisterEffect(e2)
end
function c13032689.atkval(e,c)
	return c:GetRank()*200
end
function c13032689.rcon(e,tp,eg,ep,ev,re,r,rp)
	return (r&REASON_COST)~=0 and re:IsActivated() and re:IsActiveType(TYPE_XYZ)
		and ep==e:GetOwnerPlayer() and e:GetHandler():GetEquipTarget()==re:GetHandler() and re:GetHandler():GetOverlayCount()>=ev-1
end
function c13032689.rop(e,tp,eg,ep,ev,re,r,rp)
	return Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end