--サイバー・フェニックス (Anime)
--Cyber Phoenix (Anime)
--Scripted by Lyris, modified by MLD
function c511007022.initial_effect(c)
	--Negate the activated effects of Spells/Traps that target a Machine monster you control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e) return e:GetHandler():IsAttackPos() end)
	e1:SetOperation(c511007022.disop)
	c:RegisterEffect(e1)
	--Draw 1 card when this card is destroyed and sent to the GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511007022(c511007022,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(function(e) return e:GetHandler():IsReason(REASON_DESTROY) end)
	e2:SetTarget(c511007022.drtg)
	e2:SetOperation(c511007022.drop)
	c:RegisterEffect(e2)
	--Double Snare check
	aux.DoubleSnareValc511007022ity(c,LOCATION_MZONE)
end
function c511007022.disfilter(c,p)
	return c:IsControler(p) and c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c511007022.disop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsMonsterEffect() or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or not re:IsActivated() then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if g:IsExists(c511007022.disfilter,1,nil,tp) and Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringc511007022(c511007022,1)) then
		Duel.NegateEffect(ev)
	end
end
function c511007022.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511007022.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end