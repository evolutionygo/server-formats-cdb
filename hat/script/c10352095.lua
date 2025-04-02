--幻惑の巻物
--Scroll of Bewitchment
function c10352095.initial_effect(c)
	aux.AddEquipProcedure(c,nil,nil,nil,nil,c10352095.target)
	--ATTRIBUTE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetCondition(c10352095.attcon)
	e2:SetValue(c10352095.value)
	c:RegisterEffect(e2)
end
function c10352095.target(e,tp,eg,ep,ev,re,r,rp,tc,chk)
	if chk==0 then return true end
	local rc=tc:AnnounceAnotherAttribute(tp)
	e:GetHandler():RegisterFlagEffect(c10352095,RESET_EVENT+RESETS_STANDARD,0,1,rc)
	e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
end
function c10352095.attcon(e)
	return e:GetHandler():GetFlagEffect(c10352095)~=0
end
function c10352095.value(e,c)
	return e:GetHandler():GetFlagEffectLabel(c10352095)
end