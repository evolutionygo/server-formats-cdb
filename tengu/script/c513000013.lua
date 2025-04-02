--スカーレッド・ノヴァ・ドラゴン
--Red Nova Dragon (Anime)
--Fixed by Larry126
function c513000013.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon procedure
	aux.AddSynchroProcedure(c,nil,2,2,aux.FilterBoolFunction(Card.IsCode,70902743),1,1)
	--Gains 500 ATK for each Tuner in your Graveyard
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c513000013.atkval)
	c:RegisterEffect(e1)
	--Cannot be destroyed by your opponent's card effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--Banish this card and negate an attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc513000013(c513000013,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c513000013.bancon)
	e3:SetTarget(c513000013.bantg)
	e3:SetOperation(c513000013.banop)
	c:RegisterEffect(e3)
	--Return this card to the field
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc513000013(c513000013,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_REMOVED)
	e4:SetCountLimit(1)
	e4:SetTarget(c513000013.rettg)
	e4:SetOperation(c513000013.retop)
	c:RegisterEffect(e4)
	--Double Tuner
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EFFECT_MULTIPLE_TUNERS)
	c:RegisterEffect(e5)
end
c513000013.material={70902743}
c513000013.listed_names={70902743}
c513000013.synchro_nt_required=1
function c513000013.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_TUNER)*500
end
function c513000013.bancon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(1-tp) and (Duel.IsAbleToEnterBP() or Duel.IsBattlePhase())
end
function c513000013.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
end
function c513000013.banop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Remove(c,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)>0 then
		c:RegisterFlagEffect(c513000013,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
		local ac=Duel.GetAttacker()
		if ac and ac:IsControler(1-tp) and Duel.SelectYesNo(tp,aux.Stringc513000013(c513000013,2)) then
			Duel.NegateAttack()
		else
			--You can negate 1 attack this turn from a monster your opponent controls
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_ATTACK_ANNOUNCE)
			e1:SetOperation(c513000013.negop)
			e1:SetReset(RESET_PHASE|PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c513000013.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker():IsControler(1-tp) and Duel.SelectYesNo(tp,aux.Stringc513000013(c513000013,2)) then
		Duel.Hint(HINT_CARD,1-tp,c513000013)
		Duel.NegateAttack()
		e:Reset()
	end
end
function c513000013.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():HasFlagEffect(c513000013) end
end
function c513000013.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.ReturnToField(c)
	end
end