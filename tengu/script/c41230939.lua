--サイバー・ダーク・ホーン
--Cyberdark Horn
function c41230939.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc41230939(c41230939,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(Cyberdark.EquipTarget(c41230939.eqfilter,true,true))
	e1:SetOperation(Cyberdark.EquipOperation(c41230939.eqfilter,c41230939.equipop,true))
	c:RegisterEffect(e1)
	aux.AddEREquipLimit(c,nil,c41230939.eqval,c41230939.equipop,e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c41230939.eqfilter(c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_DRAGON)
end
function c41230939.eqval(ec,c,tp)
	return ec:IsControler(tp) and ec:IsLevelBelow(3) and ec:IsRace(RACE_DRAGON)
end
function c41230939.equipop(c,e,tp,tc)
	local atk=tc:GetTextAttack()
	if atk<0 then atk=0 end
	if not c:EquipByEffectAndLimitRegister(e,tp,tc) then return end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetValue(atk)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD)
	e3:SetValue(c41230939.repval)
	tc:RegisterEffect(e3)
end
function c41230939.repval(e,re,r,rp)
	return (r&REASON_BATTLE)~=0
end