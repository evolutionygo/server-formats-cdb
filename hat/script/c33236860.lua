--BF－孤高のシルバー・ウィンド
--Blackwing - Silverwind the Ascendant
function c33236860.initial_effect(c)
	--Synchro Summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsSetCard,0x33),1,1,aux.NonTuner(nil),2,99)
	c:EnableReviveLimit()
	--Destroy up to 2 monsters
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc33236860(c33236860,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c33236860.descon)
	e1:SetCost(c33236860.descost)
	e1:SetTarget(c33236860.destg)
	e1:SetOperation(c33236860.desop)
	c:RegisterEffect(e1)
	--Prevent the destruction of a "Blackwing" monster by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e) return Duel.IsTurnPlayer(1-e:GetHandlerPlayer()) end)
	e2:SetTarget(function (e,c) return c:IsSetCard(0x33) end)
	e2:SetValue(c33236860.indesval)
	c:RegisterEffect(e2)
end
c33236860.listed_series={0x33}
function c33236860.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c33236860.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c33236860.filter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk-1)
end
function c33236860.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33236860.filter(chkc,c:GetAttack()) end
	if chk==0 then return Duel.IsExistingTarget(c33236860.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetAttack()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33236860.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c33236860.desfilter(c,e,atk)
	return c:IsFaceup() and c:IsRelateToEffect(e) and c:IsDefenseBelow(atk-1)
end
function c33236860.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c33236860.desfilter,nil,e,c:GetAttack())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c33236860.indesval(e,re,r,rp)
	return r&REASON_BATTLE>0
end