--ハイパーサイコガンナー
--Hyper Psychic Blaster
function c95526884.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTunerEx(Card.IsRace,RACE_PSYCHIC),1,99)
	c:EnableReviveLimit()
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc95526884(c95526884,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c95526884.reccon)
	e2:SetTarget(c95526884.rectg)
	e2:SetOperation(c95526884.recop)
	c:RegisterEffect(e2)
end
function c95526884.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c,a,d,def=e:GetHandler(),Duel.GetAttacker(),Duel.GetAttackTarget(),0
	if not d then return false end
	if not d:IsLocation(LOCATION_MZONE) then
		def=d:GetPreviousDefenseOnField()
	else
		def=d:GetDefense()
	end
	local m=a:GetAttack()-def
	e:SetLabel(m)
	return c==a and def>=0 and m>0 and (d:GetBattlePosition()&POS_DEFENSE)~=0
end
function c95526884.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabel())
end
function c95526884.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end