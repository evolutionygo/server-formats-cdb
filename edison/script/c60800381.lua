--ジャンク・ウォリアー
--Junk Warrior
function c60800381.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c60800381.tfilter,1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc60800381(c60800381,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60800381.con)
	e1:SetOperation(c60800381.op)
	c:RegisterEffect(e1)
end
c60800381.material={63977008}
c60800381.listed_names={63977008}
c60800381.material_setcode=0x1017
function c60800381.tfilter(c,lc,stype,tp)
	return c:IsSummonCode(lc,stype,tp,63977008) or c:IsHasEffect(20932152)
end
function c60800381.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c60800381.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsLevelBelow,2),tp,LOCATION_MZONE,0,nil)
	if #g>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=g:GetSum(Card.GetAttack)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end