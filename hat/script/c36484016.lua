--ミラクルシンクロフュージョン
--Miracle Synchro Fusion
function c36484016.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,function(c) return c.miracle_synchro_fusion end,Fusion.OnFieldMat(Card.IsAbleToRemove),c36484016.fextra,Fusion.BanishMaterial,nil,nil,nil,nil,nil,nil,nil,nil,nil,c36484016.extratg)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc36484016(c36484016,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c36484016.drcon)
	e2:SetTarget(c36484016.drtg)
	e2:SetOperation(c36484016.drop)
	c:RegisterEffect(e2)
end
function c36484016.fcheck(tp,sg,fc)
	return sg:IsExists(aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO,fc,SUMMON_TYPE_FUSION,tp),1,nil)
end
function c36484016.fextra(e,tp,mg)
	if not Duel.IsPlayerAffectedByEffect(tp,69832741) then
		return Duel.GetMatchingGroup(Fusion.IsMonsterFilter(Card.IsAbleToRemove),tp,LOCATION_GRAVE,0,nil),c36484016.fcheck
	end
	return nil,c36484016.fcheck
end
function c36484016.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,LOCATION_MZONE+LOCATION_GRAVE)
end
function c36484016.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (r&0x41)==0x41 and rp~=tp and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
end
function c36484016.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c36484016.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end